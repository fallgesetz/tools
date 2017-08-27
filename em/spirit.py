from bs4 import BeautifulSoup
import sqlite3
import requests

def getFlightInfo(flight_num):
    google_url = "https://www.google.com/search?q=spirit+" + str(flight_num)
    headers={"User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.101 Safari/537.36"}
    r = requests.get(google_url, headers=headers)
    soup = BeautifulSoup(r.text, "html.parser")
    for div in soup.find_all("div", class_="_Q1q"):
        if div['data-has_arrived'] == 'y' and div['data-has_departed'] == 'y':
            return {
                        "number":div['data-flight_number'],
                        "arrival_delay": div['data-arrival_delay'],
                        "arrival_time": div['data-arrival_time'],
                        "departure_delay": div['data-departure_delay'],
                        "departure_time": div['data-departure_time']
                }

def insertIntoSqlite(flightObject):
    conn = sqlite3.connect("spirit.db")
    c = conn.cursor()
    c.execute("INSERT into times VALUES ('" + flightObject['arrival_time'] + "','" + flightObject['arrival_delay'] + "','" + flightObject["departure_time"]+"','" + flightObject["departure_delay"] + "','" + flightObject['number'] + "')") 
    conn.commit()
    conn.close()

obj = getFlightInfo(849)
insertIntoSqlite(obj)
obj = getFlightInfo(848)
insertIntoSqlite(obj)
