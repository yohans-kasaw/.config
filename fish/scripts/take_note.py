#!/usr/bin/env python3

import argparse
import os
from difflib import get_close_matches
from typing import List, Tuple, Union

NOTES_FILE = os.path.expanduser("~/life_nots/note.md")

def ensure_file_exists():
    """Ensure the notes file and directory exist."""
    notes_dir = os.path.dirname(NOTES_FILE)
    if not os.path.exists(notes_dir):
        os.makedirs(notes_dir)
    if not os.path.exists(NOTES_FILE):
        with open(NOTES_FILE, 'w') as f:
            f.write("# Notes\n")

def get_headers(content: str) -> List[Tuple[int, str]]:
    """Get all headers with their line numbers."""
    headers = []
    for i, line in enumerate(content.splitlines()):
        if line.startswith('#'):
            headers.append((i, line.strip('# ').lower()))
    return headers

def find_matching_headers(content: str, header_query: str) -> List[Tuple[int, str]]:
    """Find headers that match the query using fuzzy matching."""
    headers = get_headers(content)
    if not headers:
        return []
    
    # Get all headers text
    header_texts = [h[1] for h in headers]
    
    # Find matches
    matches = get_close_matches(header_query.lower(), header_texts, n=3, cutoff=0.6)
    
    # Return matching headers with their line numbers
    return [(line_num, header) for line_num, header in headers if header in matches]

def add_note(note: str, header: Union[str, None] = None, is_header: bool = False):
    """Add a note to the file."""
    ensure_file_exists()
    
    with open(NOTES_FILE, 'r') as f:
        content = f.read()
    
    lines = content.splitlines()
    
    if is_header:
        # Add as a new header
        new_content = content + f"\n# {note}\n"
    elif header:
        # Find matching headers
        matches = find_matching_headers(content, header)
        
        if not matches:
            print(f"No matching headers found for '{header}'")
            return
        
        if len(matches) > 1:
            print("Multiple matching headers found:")
            for i, (_, h) in enumerate(matches, 1):
                print(f"{i}. {h}")
            try:
                choice = int(input("Choose a header (enter number): ")) - 1
                if choice < 0 or choice >= len(matches):
                    print("Invalid choice")
                    return
            except ValueError:
                print("Invalid input")
                return
            
            target_line = matches[choice][0]
        else:
            target_line = matches[0][0]
        
        # Find where to insert the new note
        insert_pos = target_line + 1
        while insert_pos < len(lines) and (not lines[insert_pos].startswith('#')):
            insert_pos += 1
        
        # Insert the new note
        lines.insert(insert_pos, f"\n\t* {note}")
        new_content = '\n'.join(lines) + '\n'
    else:
        # Add as a new bullet point at the end
        new_content = content + f"\n\t* {note}"
    
    with open(NOTES_FILE, 'w') as f:
        f.write(new_content)

def main():
    parser = argparse.ArgumentParser(description='Add notes to your markdown file')
    parser.add_argument('note', nargs='+', help='The note to add')
    parser.add_argument('--header', '-t', help='Add note under this header (fuzzy matching)')
    parser.add_argument('--as-header', '-T', action='store_true', help='Add the note as a new header')
    
    args = parser.parse_args()
    
    note_text = ' '.join(args.note)
    add_note(note_text, args.header, args.as_header)

if __name__ == "__main__":
    main()

