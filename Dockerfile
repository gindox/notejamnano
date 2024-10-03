FROM mcr.microsoft.com/windows/nanoserver:ltsc2022

USER Administrator

RUN curl -o c:\nodejs.zip https://nodejs.org/dist/v15.10.0/node-v15.10.0-win-x64.zip

RUN tar -xf c:\nodejs.zip -C C:\Windows\System32 --strip 1

RUN del c:\nodejs.zip

WORKDIR /app

COPY . .

RUN npm install

RUN node db.js

EXPOSE 3000

ENTRYPOINT ["node", "bin/www"]
