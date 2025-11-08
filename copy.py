import os
import subprocess
import argparse
from pathlib import Path
import fnmatch

def load_gitignore_patterns(root_dir):
    gitignore_path = os.path.join(root_dir, '.gitignore')
    patterns = []
    if os.path.exists(gitignore_path):
        with open(gitignore_path, 'r') as f:
            for line in f:
                line = line.strip()
                if line and not line.startswith('#'):
                    patterns.append(line)
    return patterns

def is_ignored(path, patterns, root_dir):
    rel_path = os.path.relpath(path, root_dir)
    for pattern in patterns:
        if fnmatch.fnmatch(rel_path, pattern) or fnmatch.fnmatch(os.path.basename(path), pattern):
            return True
    return False

def is_binary_file(filepath):
    try:
        with open(filepath, 'rb') as f:
            chunk = f.read(1024)
            return b'\0' in chunk
    except Exception:
        return True

def generate_tree_with_contents(root_dir):
    tree_output = []
    patterns = load_gitignore_patterns(root_dir)

    for dirpath, dirnames, filenames in os.walk(root_dir):
        if is_ignored(dirpath, patterns, root_dir):
            continue

        level = dirpath.replace(root_dir, '').count(os.sep)
        indent = '    ' * level
        tree_output.append(f"{indent}{os.path.basename(dirpath)}/")

        subindent = '    ' * (level + 1)
        for fname in filenames:
            file_path = os.path.join(dirpath, fname)
            if is_ignored(file_path, patterns, root_dir):
                continue

            tree_output.append(f"{subindent}{fname}")
            if is_binary_file(file_path):
                tree_output.append(f"{subindent}    [Binary file skipped]")
                continue
            try:
                with open(file_path, 'r', encoding='utf-8') as f:
                    contents = f.read()
                content_lines = contents.splitlines()
                for line in content_lines:
                    tree_output.append(f"{subindent}    {line}")
            except Exception as e:
                tree_output.append(f"{subindent}    [Error reading file: {e}]")

    return '\n'.join(tree_output)

def copy_to_clipboard(text):
    try:
        subprocess.run(['wl-copy'], input=text.encode('utf-8'), check=True)
        print("✅ Treeview copied to clipboard using wl-copy.")
    except Exception as e:
        print(f"❌ Clipboard copy failed: {e}")

def main():
    parser = argparse.ArgumentParser(description="Generate treeview of directory with file contents and copy to clipboard.")
    parser.add_argument("directory", help="Directory to scan")
    args = parser.parse_args()

    root_dir = os.path.abspath(args.directory)
    if not os.path.isdir(root_dir):
        print("Invalid directory path.")
        return

    tree_text = generate_tree_with_contents(root_dir)
    copy_to_clipboard(tree_text)

if __name__ == "__main__":
    main()
