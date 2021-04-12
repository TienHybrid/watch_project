# -*- coding: utf-8 -*-
import os
import time
from datetime import datetime
from logging import getLogger


logger = getLogger(__name__)


def get_vn_time_now():
    """
    Get VN time now
    :return: current time with VN timezone
    """
    return datetime.now()



