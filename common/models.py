"""models.py
"""

DEFAULT_SORT_FIELD = "id"
DEFAULT_SORT_ORDER = "desc"


# Common Classes
class Pagination:
    def __init__(
            self,
            page,
            limit,
            keyword="",
            sort_order=DEFAULT_SORT_FIELD,
            sort_field=DEFAULT_SORT_ORDER,
    ):
        self.page = page
        self.limit = limit
        self.keyword = keyword
        self.sort_order = sort_order
        self.sort_field = sort_field

    @classmethod
    def from_arguments(cls, args):
        keyword = "" if not args.keyword else args.keyword
        sort_field = DEFAULT_SORT_FIELD if not args.sort_field else args.sort_field
        sort_order = DEFAULT_SORT_ORDER if not args.sort_order else args.sort_order
        return cls(args.page, args.limit, keyword, sort_order, sort_field)
