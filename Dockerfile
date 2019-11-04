#FROM jupyter/scipy-notebook:2ce7c06a61a1
FROM jupyter/scipy-notebook:6c3390a9292e

WORKDIR /home/jovyan/

# Modules
COPY requirements.txt /home/jovyan/requirements.txt
RUN pip install -r /home/jovyan/requirements.txt

# Add files
COPY notebooks /home/jovyan/notebooks

# Allow user to write to directory
USER root
RUN chown -R $NB_USER /home/jovyan \
    && chmod -R 774 /home/jovyan \
    && rm -fR /home/jovyan/work
USER $NB_USER

# Expose the notebook port
EXPOSE 8888

# Start the notebook server
CMD jupyter notebook --no-browser --port 8888 --ip=0.0.0.0 --NotebookApp.token='' --NotebookApp.disable_check_xsrf=True --NotebookApp.iopub_data_rate_limit=1.0e10
