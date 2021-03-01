FROM mcr.microsoft.com/windows/servercore:2004 as installer

RUN powershell "(New-Object System.Net.WebClient).DownloadFile('https://nodejs.org/dist/v15.10.0/node-v15.10.0-win-x64.zip', 'c:\nodejs.zip')" 

RUN powershell "Expand-Archive nodejs.zip -DestinationPath C:\; Rename-Item 'C:\\node-v15.10.0-win-x64' c:\nodejs"

FROM mcr.microsoft.com/windows/nanoserver:2004

COPY --from=installer C:/nodejs/ C:/Windows/System32/

WORKDIR /app

COPY . .

RUN npm install

RUN node db.js

EXPOSE 3000

ENTRYPOINT ["node", "bin/www"]