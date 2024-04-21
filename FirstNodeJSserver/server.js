const express = require('express');
const app = express();
const port = 3000;
const multer  = require('multer');
const upload = multer({ dest: 'uploads/' });
app.use(express.json());


const sql = require('mssql');

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


app.get('/api/posts', async (req, res) => {
    try {
      const result = await sql.query('SELECT * FROM dbo.Posts');
      res.json(result.recordset);
    } catch (error) {
      console.error('Error fetching posts:', error.message);
      res.status(500).send('Internal Server Error');
    }
  });
  
  
  app.post('/api/posts', async (req, res) => {
    const { Content } = req.body;
  
    if (!Content) {
      return res.status(400).send('Content is required');
    }
  
    try {
      const result = await sql.query`
        INSERT INTO dbo.Posts (Content, CreatedAt)
        VALUES (${Content}, GETDATE());
      `;
      res.status(201).json(result.recordset[0]);
    } catch (error) {
      console.error('Error adding post:', error.message);
      res.status(500).send('Internal Server Error');
    }
  });
  
  
  app.post('/api/upload', upload.single('image'), async (req, res) => {
    try {
      const imageBuffer = req.file.buffer; // Get the image data as a buffer
      // Store the imageBuffer in the database using SQL queries or ORM methods
      // Example SQL query: INSERT INTO Posts (Content, Image, CreatedAt) VALUES (?, ?, GETDATE())
      res.status(201).send('Image uploaded successfully');
    } catch (error) {
      console.error('Error uploading image:', error.message);
      res.status(500).send('Internal Server Error');
    }
  });
  
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
