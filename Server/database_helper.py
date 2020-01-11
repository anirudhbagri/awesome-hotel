import mysql.connector

mydb = mysql.connector.connect(
      host="localhost",
      user="root",
      passwd="newpassword",
      database="akamai"
)

class DBHelper:
      @staticmethod
      def getAllListing(limit = 10):
            curr = mydb.cursor()
            curr.execute("SELECT * FROM listings LIMIT " + str(limit) + ";")
            result = curr.fetchall()
            return result
			
      def getAllListingByName(name):
            curr = mydb.cursor()
            curr.execute("SELECT * FROM listings WHERE name LIKE '" + name +"%' ;" + str(limit))
            result = curr.fetchall()
            return result

      def saveNewHotel(hotelData):
            name = hotelData['name']
            host_name = hotelData['host_name']
            neighbourhood_group = hotelData['neighbourhood_group']
            neighbourhood = hotelData['neighbourhood']
            latitude = hotelData['latitude']
            longitude = hotelData['longitude']
            room_type = hotelData['room_type']
            price = hotelData['price']
            curr = mydb.cursor()
			#TODO: Write the correct insert query
            curr.execute("INSERT INTO listings VALUES( "+ name + ", " + host_name + ", " + neighbourhood + ", " + neighbourhood_group + ", " + latitude + ", " + longitude + ", " + room_type + ", " + price + ", " + " )")
            print(name)