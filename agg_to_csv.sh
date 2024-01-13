#!/bin/bash
# agg_to_csv.sh

output_dir="/home/ubuntu/sentiment/outputs"
csv_file="/home/ubuntu/sentiment/sentiment_results.csv"

# Create or clear the CSV file
echo "Text,Sentiment,Score" > "$csv_file"

# Loop through each output file and extract the sentiment data
for file in "$output_dir"/sentiment_*.out; do
    if [[ -f $file ]]; then
        # Extract the line containing sentiment data
        sentiment_line=$(grep '^Text:' "$file")

        if [[ $sentiment_line ]]; then
            # Read the text, sentiment, and score
            read -r text sentiment score <<< $(echo $sentiment_line | awk -F'[:]' '{print $2,$3,$4}')

            # Clean and format the text for CSV
            text_clean=$(echo "$text" | sed -e 's/^ //' -e 's/,//')
            sentiment_clean=$(echo "$sentiment" | sed -e 's/^ //' -e 's/,//')
            score_clean=$(echo "$score" | sed -e 's/^ //' -e 's/)//')

            # Append to the CSV file
            echo "\"$text_clean\",\"$sentiment_clean\",\"$score_clean\"" >> "$csv_file"
        fi
    fi
done
