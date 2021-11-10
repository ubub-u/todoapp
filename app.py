from flask import Flask, json, request, redirect, url_for, jsonify
from flask.templating import render_template
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
import sys


app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://ubu:tootechnical@localhost:5432/todoapp'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

migrate = Migrate(app, db)

class Todo(db.Model):
    __tablename__ = 'todos'
    id = db.Column(db.Integer, primary_key=True)
    description = db.Column(db.String(), nullable=False)
    completed = db.Column(db.Boolean, nullable=False, default=False)
    list_id = db.Column(db.Integer, db.ForeignKey('todolist.id'), nullable=False)

class TodoList(db.Model):
    __tablename__ = 'todolist'
    id = db.Column(db.Integer(), primary_key=True)
    name = db.Column(db.String(), nullable=False)
    completed = db.Column(db.Boolean, nullable=False, default=False)
    todos = db.relationship('Todo', backref='list', lazy=True)




# db.create_all()

@app.route('/newlist/<new_list_id>deletodos')
def list_delete_todos(new_list_id):
    try:
        query = TodoList.query.get(new_list_id)
        db.session.delete(query)
        db.session.commit()
    except:
        db.session.rollback()
        print('todolist delete:', sys.exc_info())
    finally:
        db.session.close()
    return redirect(url_for('index'))


@app.route('/newlist/<list_ids>delete', methods=['POST'])
def list_delte(list_ids):
    try:
        todos = Todo.query.join(TodoList).filter(Todo.list_id==list_ids).all()
        print(todos)
        for each in todos:
            db.session.delete(each)
        db.session.commit()
    except:
        db.session.rollback()
        print('todos delete',sys.exc_info())
    finally:
        db.session.close()
    return redirect(url_for('list_delete_todos', new_list_id=list_ids))




@app.route('/newlist/<list_ids>checkboxes', methods=['POST'])
def list_checkbox(list_ids):
    try: 
        completed = request.get_json()['completed']
        query = TodoList.query.get(list_ids)
        query.completed = completed
        db.session.commit()
    except:
        db.session.rollback
        print(sys.exc_info())
    finally:
        db.session.close()
    return redirect(url_for('index'))


@app.route('/newlist/create', methods=['POST'])
def create_list():
    name = request.get_json()['name']
    list = TodoList(name=name)
    db.session.add(list)
    db.session.commit()
    body = {'name': list.name}
    db.session.close()
    return jsonify(body['name'])



@app.route('/todos/create', methods=['POST'])
def create_todo():
    error = False
    body = {}
    try:
        description = request.get_json()['description']
        id_list = request.get_json()['list_id']
        parent = TodoList.query.get(id_list)
        todo = Todo(description=description, list=parent)
        db.session.add(todo)
        db.session.commit()
        body['description'] = todo.description
        body['list_id'] = parent.id
    except:
        db.session.rollback()
        print('is this printing?',sys.exc_info())
    finally:
        db.session.close()
    return jsonify(body)


@app.route('/todos/<todo_id>set-completed', methods=['POST'])
def set_completed_todo(todo_id):
    error = False
    body = {}
    try:
        completed = request.get_json()['completed']
        todo = Todo.query.get(todo_id)
        todo.completed = completed
        db.session.commit()
    except:
        db.session.rollback()
        print(sys.exc_info())
        error = True
    finally:
        db.session.close()
    return redirect(url_for('index'))

@app.route('/todos/<todo_id>delete', methods=['POST'])
def delete_todo(todo_id):
    try:
        todo = Todo.query.get(todo_id)
        db.session.delete(todo)
        db.session.commit()
    except:
        db.session.rollback()
        print(sys.exc_info())
    finally:
        db.session.close()
    return redirect(url_for('index'))



            

@app.route('/lists/<list_id>')
def get_list_todos(list_id):
    return render_template('index.html', 
    lists=TodoList.query.all(),
    active_list = TodoList.query.get(list_id),
    todos=Todo.query.filter_by(list_id=list_id).order_by('id').all())

@app.route('/')
def index():
    return redirect(url_for('get_list_todos', list_id=1))



if __name__ == '__main__':
    app.run(debug=True)