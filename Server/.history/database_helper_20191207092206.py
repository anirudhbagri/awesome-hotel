import mysql.connector

mydb = mysql.connector.connect(
      host="localhost",
      user="root",
      passwd="newpassword",
      database="akamai"
)

class DBHelper:
      def getAllListing(limit):
            curr = mydb.cursor()
            curr.execute("SELECT * FROM listings")