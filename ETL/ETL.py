from extract import extract_data
from transform import transform_data
from load import load_all

def main():
    df = extract_data()
    transform_data(df)
    load_all()

if __name__ == "__main__":
    main()
