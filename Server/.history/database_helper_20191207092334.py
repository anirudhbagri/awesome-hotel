import mysql.connector

mydb = mysql.connector.connect(
      host="localhost",
      user="root",
      passwd="newpassword",
      database="akamai"
)

class DBHelper:
      static def getAllListing(self, limit):
            curr = mydb.cursor()
            curr.execute("SELECT * FROM listings LIMIT $limit")
            result = curr.fetchall()
            return result