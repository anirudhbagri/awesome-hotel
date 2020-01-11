from database_helper import DBHelper
from flask import Flask
from flask import jsonify
app = Flask(__name__) 
  
@app.route('/ping') 
def hello_world(): 
    return 'Pong'
	
@app.route('/listing/<limit>') 
def get_votes(limit = 5):
    res = DBHelper.getAllListing(limit)
    print(res)
    return jsonify(res)

# main driver function 
if __name__ == '__main__': 
  app.run(host='0.0.0.0', port=2323)