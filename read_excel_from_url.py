import pandas as pd
import requests

def read_google_sheet(url):
    try:
        response = requests.get(url)
        with open('data.xlsx', 'wb') as f:
            f.write(response.content)
        
        data = pd.read_excel('data.xlsx')
        return data
    except Exception as e:
        print("Error:", e)
        return None

if __name__ == "__main__":
    url = input("Enter Google Sheets URL: ")
    data = read_google_sheet(url)
    if data is not None:
        print(data)
