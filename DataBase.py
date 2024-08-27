from datetime import datetime
import sqlite3 as sql
import csv as excel
import os
tableName = "EmailDataBase"
database = "emailDataBase.db"

def createTable():
    conn = sql.connect(database)
    cursor = conn.cursor()

    cursor.execute(
        '''SELECT name FROM sqlite_master WHERE type='table' AND name=?;''', (tableName,))
    result = cursor.fetchone()

    if result is None:
        create_table_sql = f'''
            CREATE TABLE IF NOT EXISTS {tableName} (
            date TEXT NOT NULL,
            time TEXT NOT NULL,
            from_address TEXT NOT NULL,
            to_address TEXT NOT NULL,
            subject TEXT NOT NULL,
            body TEXT NOT NULL
            );
            '''
        cursor.execute(create_table_sql)
        conn.commit()
        print(f"Table '{tableName}' created successfully.")
    else:
        print(f"Table '{tableName}' already exists!")

    conn.close()

def insert(fromEmail, toEmail, subject, body):
    try:
        now = datetime.now()
        formatted_date = now.date().strftime("%d-%m-%Y")
        formatted_time = now.time().strftime("%H:%M:%S")
        conn = sql.connect(database)
        cursor = conn.cursor()
        insert_sql = f'''
        INSERT INTO {tableName} (date, time, from_address, to_address, subject, body)
        VALUES (?, ?, ?, ?, ?, ?);
        '''
        cursor.execute(insert_sql, (formatted_date, formatted_time, fromEmail, toEmail, subject, body))
        conn.commit()
        print("Record inserted successfully")
        return True
    except:
        return False
    finally:
        conn.close()

# def delete():
#     conn = sql.connect(database)
#     cursor = conn.cursor()
#     query = f'''
#     delete FROM {tableName};
#     '''
#     print("all records deleted")
#     cursor.execute(query)
#     conn.close()


# def showData():
#     conn = sql.connect(database)
#     cursor = conn.cursor()
#     query = f'''
#     SELECT * FROM {tableName};
#     '''
#     cursor.execute(query)
#     conn.close()

def dataBasetoCsv(fileName, Date):
    conn = sql.connect(database)
    cursor = conn.cursor()
    query = f'''
    SELECT * FROM {tableName} WHERE date = ?;
    '''
    cursor.execute(query, (Date,))
    rows = cursor.fetchall()
    if not rows:
        print(f"No records found for the date: {Date}")
        cursor.close()
        conn.close()
        return False
    else:
     path = "D:\\PyQt\\EmailManager\\csvFiles"
     csvfile = os.path.join(path, f"{fileName}.csv")
     column_names = [description[0] for description in cursor.description]
     csvFileName = csvfile
     with open(csvFileName, mode='w', newline='') as file:
        writer = excel.writer(file)
        writer.writerow(column_names)
        writer.writerows(rows)
     cursor.close()
     conn.close()
     return True

