
from flask import Flask
from flask_restful import Resource, Api
from flask_restful import reqparse
from flaskext.mysql import MySQL
from flask_cors import CORS

mysql = MySQL()
app = Flask(__name__)
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = 'root'
app.config['MYSQL_DATABASE_DB'] = 'madrid'
app.config['MYSQL_DATABASE_HOST'] = 'flask-db'
app.config['MYSQL_DATABASE_PORT'] = 6000

mysql.init_app(app)
api = Api(app)
cors = CORS(app, resources={"/madrid": {"origins": "*"}})

class Orquestator(Resource):
    def post(self):
        try:
            parser = reqparse.RequestParser()
            parser.add_argument('name', type=str)
            parser.add_argument('tshirt', type=int)
            parser.add_argument('position', type=str)
            args = parser.parse_args()

            parameters = [args['name'],args['tshirt'],args['position']]
            
            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('sp_md_create_player', parameters)
            conn.commit()
            return {'says':'ok'}, 201

        except Exception as e:
            return {'says': 'error'}, 500, {'Etag': str(e)}

    def get(self):
        try:
            # Array for response
            players=[]

            parser = reqparse.RequestParser()
            parser.add_argument('position', type=str)
            args = parser.parse_args()

            parameters=[args['position']]
            
            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('sp_md_find_player', parameters)
            data = cursor.fetchall()

            for row in data:
                player = {
                    'idNative':row[0],
                    'name':row[1],
                    'tshirt':row[2],
                    'position':row[3]
                }
                players.append(player)

            return {'body': players}

        except Exception as e:
            return {'api-says': 'error'}, 404, {'Etag': str(e)}

api.add_resource(Orquestator, '/madrid')

if __name__ == '__main__':
   app.run(debug=True, host='0.0.0.0')




