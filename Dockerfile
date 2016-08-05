FROM foodresearch/bppc
MAINTAINER Mark Fernandes <mark.fernandes@ifr.ac.uk>
#
# Docker container for enhanced commad-line environment 
# e.g.  for Ethan Cermi's Samtools primer course
#
USER root 
ENV   SIAB_USER=guest \
  SIAB_GROUP=guest \
  SIAB_PASSWORD=ngsintro \
  SIAB_HOME=/home/$SIAB_USER 
ENV COURSEDIR=/home/guest
# NB /home and below are a VOLUME in bppc Dockerfile. Ports 22 & 4200 EXPOSEd

COPY welcome.txt /etc/motd
RUN mkdir /tools /course_material
RUN apt-get update && apt-get install -y samtools bowtie2 git lighttpd poppler-utils supervisor
# we need supervisor as we're running 2 processes (minimum of shellinaboxd & lighttpd)

# Run install_tools.sh here e.g. containing apt-gets, makes, ngit clones etc

# instal htslib & bcftools from source (do for Samtools also?)
RUN cd /tools && git clone https://github.com/samtools/htslib.git  && git clone https://github.com/samtools/bcftools.git  
RUN git clone https://github.com/samtools/samtools.git
RUN mkdir /usr/local/bin/plugins
RUN cd /tools/htslib && make install
# RUN cd /tools/bcftools && make install
RUN cd /course_material && git clone https://github.com/ecerami/samtools_primer.git ./

# Hopefully that's all pre-requisites in place
# RUN chown -R guest.guest $COURSEDIR
EXPOSE 80
ENTRYPOINT ["/scripts/launchsiab.sh"]
CMD ["/bin/bash"]
