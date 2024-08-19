source ./util.sh

api POST "$ADMIN_API_BASE"'/api/usersLoad' \
 --data-raw '
{
  "orderBy": [
    "status",
    "fullName"
  ],
  "limit": 15,
  "page": 1,
  "totalCount": true
}
'
