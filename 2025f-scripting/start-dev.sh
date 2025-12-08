cd msanh && \
DJANGO_DEBUG=true python manage.py migrate && \
DJANGO_DEBUG=true python manage.py runserver && \