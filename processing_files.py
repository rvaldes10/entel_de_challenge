
from dotenv import load_dotenv
# import json
import awswrangler as wr
# import urllib.parse
import boto3

s3 = boto3.resource('s3') 

# Variables Constantes
BUCKET = 'testing-dataengineer'
READ_PREFIX = 'pre-stage/'
PROCESSED_PREFIX = 'post-stage/'
# BKP_PREFIX = 'history/'

csv_cols_dict = {
    'departments': ['id','department'],
    'hired_employees': ['id','name', 'datetime', 'department_id', 'job_id'],
    'jobs': ['id', 'job'],
}

cast_int_cols = ['department_id', 'job_id']

def format_files():
    # Get bucket reference
    s3_bucket = s3.Bucket(BUCKET)

    csv_files = [obj.key for obj in s3_bucket.objects.filter(Prefix=READ_PREFIX) if obj.key.endswith('.csv')]

    print(f'csv_files: {csv_files}')

    # Recorremos todos los archivos dentro de READ_PREFIX que contiene el RAW
    for f in csv_files:
        csv_location = f's3://{s3_bucket.name}/{f}'
        output_lcoation = f's3://{s3_bucket.name}/{PROCESSED_PREFIX}'
        file_name = f.split('/')[1].split('.')[0]
        print(f'Leyendo archivo {f}' )
        df = wr.s3.read_csv(path=csv_location, sep=',', header=None, names=csv_cols_dict[file_name])
        if file_name == 'hired_employees':
            for col in cast_int_cols:
                df[col] = df[col].astype('Int64')
        print(f'{file_name} columns: {df.columns}')
        print(f'Generando CSV formateado')
        print(f'output_path : {output_lcoation}{file_name}/')
        wr.s3.to_csv(df=df, path=f'{output_lcoation}{file_name}/{file_name}_processed.csv', sep='|', index=False)
        print("Archivo generado con exito.")
    print('Todos los archivos han sido procesados')


def main():
    format_files()
    

if __name__ == "__main__":
    main()