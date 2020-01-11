from database_helper import mydb

def returnVotes():
    return {"yes_count": yes_count, "no_count": no_count}

def printVotes():
  print('Yes: ' + str(yes_count) + ' : ' + 'No: ' + str(no_count))

from flask import Flask
from flask import jsonify
app = Flask(__name__) 
  
@app.route('/ping') 
def hello_world(): 
    return 'Pong'
	
@app.route('/votes') 
def get_votes():
    printVotes()
    return jsonify(returnVotes())

# main driver function 
if __name__ == '__main__': 
  app.run(host='0.0.0.0', port=5000)