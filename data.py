import sys
from transformers import pipeline

def analyze_sentiment(text):
    sentiment_pipeline = pipeline("sentiment-analysis", model="distilbert-base-uncased-finetuned-sst-2-english")
    return sentiment_pipeline(text)

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("No text provided for analysis")
        sys.exit(1)

    text_to_analyze = sys.argv[1]  # Corrected this line
    result = analyze_sentiment(text_to_analyze)
    print(f"Text: {text_to_analyze}, Sentiment: {result[0]['label']}, Score: {result[0]['score']:.2f}")
