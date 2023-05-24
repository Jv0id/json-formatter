FROM nginx
RUN npm install
RUN npm run dev
COPY dist /usr/share/nginx/html
