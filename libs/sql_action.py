#!/usr/bin/python -tt
# -*- coding: utf-8 -*-

"""sql_action.py: Sql action"""
from logging import getLogger

from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()
logger = getLogger(__name__)


def safe_commit():
    """
    Commit change and rollback if the commit error
    :return:
    """
    try:
        db.session.commit()
    except Exception as e:
        logger.exception(f"Can not commit change, error = {e}")
        db.session.rollback()
        raise
