from flask import Flask,request,render_template
from flask_mysqldb import MySQL

app = Flask(__name__)
############################ DB-Config ###########################
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'db_mitarbeiterverwaltung'

mysql = MySQL(app)

##########################  Index  #########################
@app.route('/')
def index():
    return render_template('index.html')


##########################  Mitarbeiterübersicht  ###########################
@app.route('/mitarbeiterübersicht', methods=['GET','POST'])
def mitarbeiteruebersicht():
    #Verindung zur Datenbank herstellen
    cursor = mysql.connection.cursor()

    #SQL abfrage
    query = '''
                SELECT tbl_mitarbeiter.*,
		tbl_mobiltelefone_mitarbeiter.*,
        tbl_geschlechter.Bezeichnung
        FROM tbl_mitarbeiter
        LEFT JOIN tbl_mobiltelefone_mitarbeiter on tbl_mitarbeiter.IDMitarbeiter = tbl_mobiltelefone_mitarbeiter.FIDMitarbeiter
        LEFT JOIN tbl_geschlechter on tbl_geschlechter.IDGeschlecht = tbl_mitarbeiter.FIDGeschlecht
        
    '''

    if request.method == 'POST':
        query_search_eintritt = request.form['eintritt']
        query_search_austritt = request.form['austritt']
        if request.form['eintritt'] and request.form['austritt']:
            query += f'''
                        WHERE tbl_mitarbeiter.Eintrittsdatum = '{query_search_eintritt}' 
                        AND  tbl_mitarbeiter.Austrittsdatum = '{query_search_austritt}';
  
                                                '''
            #print(query)

        elif request.form['eintritt']:
            query += f'''
                        WHERE tbl_mitarbeiter.Eintrittsdatum = '{query_search_eintritt}'
                        ORDER by tbl_mitarbeiter.Eintrittsdatum
                        '''

        elif request.form['austritt']:
            query += f'''
                        WHERE tbl_mitarbeiter.Austrittsdatum = '{query_search_austritt}'
                        ORDER by tbl_mitarbeiter.Eintrittsdatum 
                                    '''



    cursor.execute(query)
    mitarbeiter = cursor.fetchall()

    return render_template('mitarbeiterübersicht.html',mitarbeiter=mitarbeiter)




########################  MitarbeiterVerwaltung  ###############################
@app.route('/mitarbeiterverwaltung')
def mitarbeiterverwaltung():
    #Verbindung zur Datenbank herstellen
    cursor = mysql.connection.cursor()

    #SQL Abfrage
    query = '''
                     SELECT tbl_mitarbeiter.*,
		tbl_mobiltelefone_mitarbeiter.*,
        tbl_geschlechter.Bezeichnung
        FROM tbl_mitarbeiter
        LEFT JOIN tbl_mobiltelefone_mitarbeiter on tbl_mitarbeiter.IDMitarbeiter = tbl_mobiltelefone_mitarbeiter.FIDMitarbeiter
        LEFT JOIN tbl_geschlechter on tbl_geschlechter.IDGeschlecht = tbl_mitarbeiter.FIDGeschlecht
        
    '''
    cursor.execute(query)
    mitarbeiter = cursor.fetchall()

    return render_template('mitarbeiterverwaltung.html',mitarbeiter=mitarbeiter)


if __name__ == '__main__':
    app.run(debug=True)