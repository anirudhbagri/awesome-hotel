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
    res = DBHelper.getAllListing()
    print(res)
    return jsonify(res))

# main driver function 
if __name__ == '__main__': 
  app.run(host='0.0.0.0', port=5000)