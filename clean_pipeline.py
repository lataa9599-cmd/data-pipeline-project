import pandas as pd
import os
import glob
import shutil
from datetime import datetime

#  1. Get latest valid file
def get_latest_file():
    
    download_path = os.path.join(os.path.expanduser("~"), "Downloads")
    raw_data_path = r"C:\Users\Suman_5728\Desktop\Suman_Project\Pipeline_Data\Row_data"
    
    os.makedirs(raw_data_path, exist_ok=True)

    search_pattern = os.path.join(download_path, "*[sS]ales*.xlsx")

    files = [
        f for f in glob.glob(search_pattern)
        if not os.path.basename(f).startswith("~$")
    ]

    if not files:
        print("No valid file found")
        return None

    latest_file = max(files, key=os.path.getmtime)
    file_name = os.path.basename(latest_file)

    destination = os.path.join(raw_data_path, file_name)

    if not os.path.exists(destination):
        shutil.copy2(latest_file, destination)
        print(f"File copied: {file_name}")
    else:
        print(f"File already exists: {file_name}")

    return destination


#  2. Clean Data
def clean_data(file_path):

    if file_path is None:
        print("No file to clean")
        return None

    df = pd.read_excel(file_path)
    df.dropna(how="all", inplace=True)

    df.columns = df.columns.str.strip()

    if "Postal Code" in df.columns:
        df["Postal Code"] = df["Postal Code"].fillna("Not Available")

    if "Sales" in df.columns:
        df["Sales"] = df["Sales"].replace('', 0)
        df["Sales"] = df["Sales"].replace(r'[\$,]', '', regex=True)
        df["Sales"] = pd.to_numeric(df["Sales"], errors='coerce').fillna(0).astype(int)

    print("Data cleaned")

    return df


#  3. Save Data (same file name)
def save_data(df, file_path):

    if df is None or file_path is None:
        print("Nothing to save")
        return None

    processed_path = r"C:\Users\Suman_5728\Desktop\Suman_Project\Pipeline_Data\Processing"
    os.makedirs(processed_path, exist_ok=True)

    file_name = os.path.basename(file_path)
    save_path = os.path.join(processed_path, file_name)

  
    if os.path.exists(save_path):
        name, ext = os.path.splitext(file_name)
        save_path = os.path.join(processed_path, f"{name}_cleaned{ext}")

    df.to_excel(save_path, index=False)

    print(f"💾 File saved: {save_path}")
    return save_path


# 4. Main Controller Function
def run_pipeline():

    file_path = get_latest_file()
    print("File Path:", file_path)

    df = clean_data(file_path)

    save_path = save_data(df, file_path)
    print("Saved Path:", save_path)

if __name__ == "__main__":
    run_pipeline()



    
  

    
        
    


        

