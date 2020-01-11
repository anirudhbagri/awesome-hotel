from database_helper import DBHelper
from flask import Flask, request
from flask import jsonify
app = Flask(__name__) 
  
@app.route('/ping') 
def hello_world(): 
    return 'Pong'
	
@app.route('/listing') 
def get_votes():
    limit = request.args.het()'limit']
    res = DBHelper.getAllListing() if limit == None else DBHelper.getAllListing(limit)
    print(res)
    return jsonify(res)

# main driver function 
if __name__ == '__main__': 
  app.run(host='0.0.0.0', port=2323)