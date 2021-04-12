from werkzeug.utils import secure_filename
import tempfile
from logging import getLogger
from libs.vn_time import get_vn_time_now
import pyrebase
import random
import string

firebaseConfig = {
    "apiKey": "AIzaSyBVQs_SrCkIAPNyqNyzTTVP9ajvtnakWd4",
    "authDomain": "calendar-bff60.firebaseapp.com",
    "databaseURL": "https://calendar-bff60.firebaseio.com",
    "projectId": "calendar-bff60",
    "storageBucket": "calendar-bff60.appspot.com",
    "messagingSenderId": "209383043766",
    "appId": "1:209383043766:web:62a3e7f68dba917d13ec17",
    "measurementId": "G-1HR1TPME8G"
}
firebase = pyrebase.initialize_app(firebaseConfig)
storage = firebase.storage()
logger = getLogger(__name__)


def uploads_banner_image(id, file, location):
    """
    :param id:
    :param file:
    :param location:
    :return:
    """
    current_date_time = get_vn_time_now()
    upload_filename = secure_filename(file.filename)
    file_format = upload_filename.split('.')
    file_to = f"{location}/detail_{id}_{current_date_time.strftime('%f')}.{file_format[1]}"
    url = None
    upload_file_path = tempfile.NamedTemporaryFile().name
    file.save(upload_file_path)
    with open(upload_file_path, 'rb') as f:
        data = f.read()
    try:
        storage.child(file_to).put(data)
        url = storage.child(file_to).get_url(None)
    except Exception as e:
        res = f"Error = {e}"
        logger.exception(res)
    return url


def random_pwd():
    """
    Get random password pf length 8 with letters, digits, and symbols
    :return:
    """
    password_characters = string.ascii_letters + string.digits + string.punctuation
    password = ''.join(random.choice(password_characters) for i in range(8))
    return password