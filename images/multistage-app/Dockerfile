FROM gcc:9.5.0-bullseye AS gcc
LABEL author="Cat Lord"

FROM gcc AS gccbuild
COPY main.c .
RUN gcc main.c -o /bin/hello

FROM scratch
# copy from the previous stage
COPY --from=1 /bin/hello /bin/hello
CMD ["/bin/hello"]
