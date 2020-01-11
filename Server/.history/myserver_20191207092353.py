from database_helper import DBHelper
from flask import Flask
from flask import jsonify
app = Flask(__name__) 
  
@app.route('/ping') 
def hello_world(): 
    return 'Pong'
	
@app.route('/votes') 
def get_votes():
    printVotes()
    DBHelper.getAllListing()
    return jsonify(returnVotes())

# main driver function 
if __name__ == '__main__': 
  app.run(host='0.0.0.0', port=5000)