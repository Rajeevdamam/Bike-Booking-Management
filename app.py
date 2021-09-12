import MySQLdb
from hashlib import md5
from flask import Flask, session, render_template, request, make_response, jsonify, redirect, url_for, flash
app = Flask(__name__, static_url_path='')
app.secret_key = 'bike_inventory_application'
db = MySQLdb.connect(host="localhost", user="root", passwd="",
                     db="bike_db", unix_socket="/Applications/XAMPP/xamppfiles/var/mysql/mysql.sock")
db.autocommit(True)


@app.route('/', methods=['GET'])
def index():
    if request.method == 'GET':
        if('username' in session):
            return redirect(url_for('dashboard'))
        else:
            return render_template("index.html")


@app.route('/login', methods=['POST', 'GET'])
def login():
    if request.method == 'POST':
        cur = db.cursor(MySQLdb.cursors.DictCursor)
        email = request.form['email']
        password = request.form['password']
        password_hash = md5(password).hexdigest()
        cur.execute(
            "SELECT * FROM user where email = %s and password = %s", [email, password_hash])
        user = cur.fetchone()
        if(user is not None):
            cur.close()
            session['username'] = user['user_name']
            session['userid'] = user['user_id']
            session['isAdmin'] = user['is_admin']
            return redirect(url_for('dashboard'))
        else:
            cur.close()
            flash("Email and password does not match", "danger")
            return render_template("index.html", tab="login")
    elif request.method == 'GET':
        if('username' in session):
            return redirect(url_for('dashboard'))
        else:
            return render_template("index.html", tab='login')


@app.route('/signup', methods=['POST'])
def signup():
    if request.method == 'POST':
        cur = db.cursor(MySQLdb.cursors.DictCursor)
        name = request.form['name']
        email = request.form['email']
        phone = request.form['phone']
        address = request.form['address']
        password = request.form['password']
        gender = request.form['gender']
        confirmpassword = request.form['confirmpassword']
        password_hash = md5(password).hexdigest()

        if name == '' or email == '' or password == '':
            flash("Please enter all details", 'danger')
            return redirect(url_for("login", tab="signup"))
        cur.execute(
            "select * from user where email=%s and user_name=%s",
            [email, name]
        )
        if password == confirmpassword:
            user = cur.fetchone()
            if user is not None:
                flash("Email or Name already exists", 'danger')
                return redirect(url_for("login", tab="signup"))
            else:
                cur.execute(
                    "insert into user(user_name,email,phone,address,password,gender) values(%s,%s,%s,%s,%s,%s)", [name, email, phone, address, password_hash, gender])
            db.commit()
            cur.close()
            flash("Signup successfull!", 'success')
            return redirect(url_for("login", tab='login'))
        else:
            flash("Passwords do not match", 'danger')
            return redirect(url_for("login", tab="signup"))


@app.route('/dashboard', methods=['POST', 'GET'])
def dashboard():
    if('username' in session):
        # print bool(session['isAdmin'])
        if request.method == 'GET':
            cur = db.cursor(MySQLdb.cursors.DictCursor)
            cur.execute(
                "select image,logo,idinventory,company_name,model_no,price from inventory i join company c on i.comp_id=c.idcompany")
            inventory_data = cur.fetchall()
            cur.execute("select company_name, logo from company")
            company_data = cur.fetchall()
            cur.execute("select name,feedback,rating from ratings")
            ratings = cur.fetchall()
            cur.close()
            return render_template("dashboard.html", inventory_data=inventory_data, company_data=company_data, isAdmin=session['isAdmin'], ratings=ratings)
        elif request.method == 'POST':
            cur = db.cursor(MySQLdb.cursors.DictCursor)
            search_text = request.form['search_text']
            print search_text
            cur.execute(
                "select i.*, c.company_name from inventory i join company c on i.comp_id=c.idcompany where c.company_name like '%" + search_text + "%' or i.model_no like '%" + search_text + "%'")
            search = cur.fetchall()
            # print search
            cur.close()
            return render_template("dashboard.html", search=search, search_text=search_text, isAdmin=session['isAdmin'])
    else:
        return redirect(url_for("login"))


@app.route('/bikeDetails/<inventory_id>', methods=['POST', 'GET'])
def bikeDetails(inventory_id):

    print inventory_id
    cur = db.cursor(MySQLdb.cursors.DictCursor)
    cur.execute(
        "select i.*, c.company_name from inventory i join company c where i.comp_id=c.idcompany and i.idinventory=%s", [int(inventory_id)])
    bike_data = cur.fetchone()
    cur.close()

    # print inventory_data
    return render_template("bikeDetails.html", bike_data=bike_data)


@app.route('/bikes', methods=['POST', 'GET'])
def bikes():

    cur = db.cursor(MySQLdb.cursors.DictCursor)
    cur.execute(
        "select i.*, c.company_name from inventory i join company c on i.comp_id=c.idcompany where p_id='10'")
    bikes = cur.fetchall()
    cur.close()

    # print bikes
    return render_template("bikes.html", bikes=bikes)


@app.route('/scooters', methods=['POST', 'GET'])
def scooters():

    cur = db.cursor(MySQLdb.cursors.DictCursor)
    cur.execute(
        "select i.*, c.company_name from inventory i join company c on i.comp_id=c.idcompany where p_id='11'")
    scooters = cur.fetchall()
    cur.close()

    # print scooters
    return render_template("scooters.html", scooters=scooters)


@app.route('/review', methods=['POST', 'GET'])
def review():
    if('userid' in session):
        if request.method == 'POST':
            cur = db.cursor(MySQLdb.cursors.DictCursor)
            name = request.form['name']
            phone = request.form['phone']
            feedback = request.form['feedback']
            rating = request.form['rating']
            cur.execute("insert into ratings(name,phone,feedback,rating,ui_id) values(%s,%s,%s,%s,%s)", [
                        name, phone, feedback, rating, session['userid']])

            db.commit()
            cur.close()
            return render_template("review.html")
        else:
            return render_template("review.html")
    else:
        return redirect(url_for('login'))


@app.route('/admin', methods=['POST', 'GET'])
def admin():
    if 'isAdmin' in session:
        if session['isAdmin']:
            cur = db.cursor(MySQLdb.cursors.DictCursor)
            cur.execute(
                "SELECT i.*,c.company_name,p.product_typecol from inventory i JOIN company c JOIN product_type p on i.comp_id=c.idcompany AND i.p_id=p.product_id"
            )
            inventory = cur.fetchall()
            cur.execute("select * from product_type")
            product = cur.fetchall()
            cur.execute("select * from company")
            company = cur.fetchall()
            cur.execute(
                "select *, IF(gender = '1', 'Male', 'Female') AS gender_str from user")
            users = cur.fetchall()
            cur.close()
            # print inventory
            # print product
            # print company
            # print users
            return render_template("admin.html", inventory=inventory, product=product, company=company, users=users, selected_index=0)
        else:
            return redirect(url_for("dashboard"))
    else:
        return redirect(url_for("login"))


@app.route('/deleteItem/<inventory_id>', methods=['POST'])
def deleteItem(inventory_id):
    cur = db.cursor(MySQLdb.cursors.DictCursor)
    cur.execute(
        "delete from inventory where idinventory=%s", [int(inventory_id)])
    cur.close()
    return redirect(url_for("admin"))


@app.route('/updateItem', methods=['POST'])
def updateItem():
    data = request.form.to_dict()
    print data
    cur = db.cursor(MySQLdb.cursors.DictCursor)
    cur.execute(
        "update inventory set model_no=%s, engine=%s, stroke=%s, price=%s, p_id=%s, year=%s, displacement=%s, transmission=%s, torque=%s,brakes=%s, comp_id=%s where idinventory=%s", [data['model_no'], data['engine'], data['stroke'], data['price'], data['p_id'], data['year'], data['displacement'], data['transmission'], data['torque'], data['brakes'], data['comp_id'], int(data['idinventory'])])
    db.commit()
    cur.close()
    return redirect(url_for("admin"))


@app.route('/bookItem/<inventory_id>', methods=['POST'])
def bookItem(inventory_id):
    if('userid' in session):
        cur = db.cursor(MySQLdb.cursors.DictCursor)
        cur.execute("select * from inventory where idinventory=%s",
                    [inventory_id])
        item = cur.fetchone()
        if(item['stock'] > 0):
            cur.callproc('insert_order', [
                         inventory_id, session['userid'], item['price']])
            flash('Booking Successfull', 'success')
            return redirect(url_for("bikeDetails", inventory_id=inventory_id))
        else:
            flash('No Stock Available', 'danger')
            return redirect(url_for("bikeDetails", inventory_id=inventory_id))


@app.route('/updateUser', methods=['POST'])
def updateUser():
    data = request.form.to_dict()
    # print data
    if('is_admin' not in data):
        data['is_admin'] = 0
    cur = db.cursor(MySQLdb.cursors.DictCursor)
    cur.execute(
        "update user set user_name=%s, phone=%s, email=%s, address=%s, is_admin=%s where user_id=%s", [data['user_name'], data['phone'], data['email'], data['address'], data['is_admin'], int(data['user_id'])])
    db.commit()

    cur.close()
    return redirect(url_for("admin"))


@app.route('/deleteUser/<user_id>', methods=['POST'])
def deleteUser(user_id):
    cur = db.cursor(MySQLdb.cursors.DictCursor)
    cur.execute(
        "delete from user where user_id=%s", [int(user_id)])
    cur.close()
    return redirect(url_for("admin"))


@app.route('/adminLogin', methods=['POST', 'GET'])
def adminLogin():
    if request.method == 'POST':
        cur = db.cursor(MySQLdb.cursors.DictCursor)
        email = request.form['email']
        password = request.form['password']
        password_hash = md5(password).hexdigest()
        cur.execute(
            "SELECT * FROM user where email = %s and password = %s and is_admin=1", [email, password_hash])
        user = cur.fetchone()
        if(user is not None):
            cur.close()
            session['username'] = user['user_name']
            session['isAdmin'] = bool(user['is_admin'])
            return redirect(url_for('dashboard'))
        else:
            cur.close()
            return render_template("adminLogin.html", error="Email and password does not match")
    elif request.method == 'GET':
        if('username' in session):
            return redirect(url_for('dashboard'))
        else:
            return render_template("adminLogin.html")


@app.route('/bookingDetails', methods=['GET'])
def bookingDetails():
    if('userid' in session):
        cur = db.cursor(MySQLdb.cursors.DictCursor)
        cur.execute(
            "SELECT u.user_name,u.phone,c.company_name,i.model_no,i.price,o.ord_date,o.ord_price FROM user u join company c join inventory i join orders o on u.user_id=o.u_id and c.idcompany=i.comp_id and i.idinventory=o.inventory_id WHERE o.u_id=%s ", [session['userid']])
        orders = cur.fetchall()
        cur.close()
        return render_template("bookingDetails.html", orders=orders)


@app.route('/logout')
def logout():
    # remove the username from the session if it is there
    session.pop('username', None)
    session.pop('isAdmin', None)
    return redirect(url_for("login"))


@app.route('/dbTest')
def dbTest():
    cur = db.cursor()
    cur.execute("SELECT * FROM user")
    users = cur.fetchall()
    cur.close()
    return render_template("users.html", users=users)


if __name__ == '__main__':
    app.run(debug='true')
