from functools import wraps

from flask import session, redirect, url_for


def is_login(func):
    @wraps(func)
    def check_login():
        if 'u_id' in session:
            return func()
        else:
            return redirect(url_for('user.login'))
    return check_login