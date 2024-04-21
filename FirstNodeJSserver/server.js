const express = require('express');
const app = express();
const port = 3000;
const multer = require('multer');
const upload = multer({ dest: 'uploads/' });
app.use(express.json());

const sql = require('mssql');
const fs = require('fs');

const config = {
  user: 'allaccess',
  password: 'HoosFit123',
  server: 'hoosfit-server.database.windows.net',
  database: 'HoosFit',
  options: {
    encrypt: true,
  },
};

async function connectToDatabase() {
  try {
    await sql.connect(config);
    console.log('Connected to the database');
  } catch (error) {
    console.error('Error connecting to the database:', error.message);
  }
}

connectToDatabase();

app.post('/api/upload', upload.single('image'), async (req, res) => {
  try {
    const content = req.body.content;

    // Get the file path where the image is stored on the server
    const imagePath = req.file.path;

    const pool = await sql.connect(config);
    const request = pool.request();

    // Read the image file as binary data
    const imageBuffer = fs.readFileSync(imagePath);

    // Insert the content and image path into the database
    request.input('content', sql.NVarChar(sql.MAX), content);
    request.input('image', sql.VarBinary, imageBuffer);
    request.query('INSERT INTO dbo.Posts (Content, ImagePath, CreatedAt) VALUES (@content, @image, GETDATE());');

    res.status(201).send('Image uploaded and post created successfully');
  } catch (error) {
    console.error('Error uploading image and creating post:', error.message);
    res.status(500).send('Internal Server Error');
  }
});

app.get('/api/posts', async (req, res) => {
  try {
    const pool = await sql.connect(config);
    const result = await pool
      .request()
      .query('SELECT * FROM dbo.Posts ORDER BY CreatedAt DESC');

    res.json(result.recordset);
  } catch (error) {
    console.error('Error fetching posts:', error.message);
    res.status(500).send('Internal Server Error');
  }
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
