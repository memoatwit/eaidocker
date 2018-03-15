# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
#Trying to merge tensorflow and nbgrader dockerfiles
FROM jupyter/tensorflow-notebook

LABEL maintainer="Jupyter Project <jupyter@googlegroups.com>"

#FROM jupyter/systemuser


# Install psychopg2
#RUN apt-get update
#RUN apt-get -y install libpq-dev
#RUN pip install psycopg2

# Install nano
#RUN apt-get -y install nano

# Install terminado
RUN pip install terminado

# Install scikit-learn
RUN pip install scikit-learn

# Install widgets
RUN pip install ipywidgets

# Install plotchecker
RUN pip install plotchecker

# Install nose
RUN pip install nose

# Install nbgrader
#RUN pip install nbgrader

# Install the nbgrader extensions
#RUN nbgrader extension install

# Create nbgrader profile and add nbgrader config
#ADD nbgrader_config.py /etc/jupyter/nbgrader_config.py

# Configure grader user
#RUN useradd -m grader
#RUN chown -R grader:grader /home/grader
#USER grader

# Where the assignments will live (these need to be mounted on runtime)
#3WORKDIR /assignments

#ENTRYPOINT ["tini", "--", "nbgrader"]
#CMD ["--help"]

#Steal from https://gist.github.com/jhamrick/45f01c1a15572e964e5b
# and https://github.com/jhamrick/nbgrader-demo/blob/master/Dockerfile

# Install notebook config
RUN pip install git+git://github.com/jupyter/nbgrader.git
ADD jupyter_notebook_config.py /home/main/.jupyter/jupyter_notebook_config.py

# Install and enable extensions
RUN jupyter nbextension install --sys-prefix --py nbgrader
RUN jupyter nbextension enable --sys-prefix --py nbgrader
RUN jupyter serverextension enable --sys-prefix --py nbgrader

ENV PYTHONPATH /home/main
ADD formgrade_extension.py /home/main/formgrade_extension.py
RUN jupyter serverextension enable --sys-prefix formgrade_extension

