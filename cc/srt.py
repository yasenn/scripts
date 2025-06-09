import json
import sys
import os
import argparse
from collections import defaultdict

def convert_to_srt_time(seconds):
    """Convert seconds to SRT time format: HH:MM:SS,mmm"""
    hours = int(seconds // 3600)
    minutes = int((seconds % 3600) // 60)
    seconds_remainder = seconds % 60
    milliseconds = int((seconds_remainder - int(seconds_remainder)) * 1000)
    return f"{hours:02d}:{minutes:02d}:{int(seconds_remainder):02d},{milliseconds:03d}"

def extract_phrases(data):
    """Group words by phraseId and extract phrase text with timing"""
    phrases = defaultdict(list)
    for word in data["words"]:
        phrases[word["phraseId"]].append(word)
    
    # Sort phrases by start time and aggregate text
    results = []
    for phrase_id, words in phrases.items():
        sorted_words = sorted(words, key=lambda x: x["startTime"])
        start_time = sorted_words[0]["startTime"]
        end_time = sorted_words[-1]["endTime"]
        text = " ".join(w["text"] for w in sorted_words)
        results.append((start_time, end_time, text))
    
    return sorted(results, key=lambda x: x[0])

def extract_words(data):
    """Extract individual words with timing"""
    words = []
    for word in data["words"]:
        words.append((word["startTime"], word["endTime"], word["text"]))
    return sorted(words, key=lambda x: x[0])

def generate_srt(entries, output_file):
    """Generate SRT file from extracted entries"""
    with open(output_file, "w", encoding="utf-8") as f:
        for i, (start, end, text) in enumerate(entries, 1):
            f.write(f"{i}\n")
            f.write(f"{convert_to_srt_time(start)} --> {convert_to_srt_time(end)}\n")
            f.write(f"{text}\n\n")

def main():
    parser = argparse.ArgumentParser(description='Generate SRT from JSON transcription')
    parser.add_argument('input_file', help='Input JSON file path')
    parser.add_argument('--mode', choices=['phrases', 'words'], default='phrases',
                        help='SRT generation mode: "phrases" (default) or "words"')
    
    args = parser.parse_args()
    
    if not os.path.isfile(args.input_file):
        print(f"Error: File not found - {args.input_file}")
        sys.exit(1)
    
    # Generate output filename
    base_name = os.path.splitext(args.input_file)[0]
    output_file = f"{base_name}_{args.mode}.srt"
    
    try:
        with open(args.input_file, "r", encoding="utf-8") as f:
            data = json.load(f)
        
        if args.mode == 'phrases':
            entries = extract_phrases(data)
        else:  # words mode
            entries = extract_words(data)
        
        generate_srt(entries, output_file)
        print(f"Successfully generated {args.mode}-based SRT: {output_file}")
        print(f"Entries processed: {len(entries)}")
    
    except Exception as e:
        print(f"Error processing file: {str(e)}")
        sys.exit(1)

if __name__ == "__main__":
    main()
