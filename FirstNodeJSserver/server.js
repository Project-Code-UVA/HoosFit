const express = require('express');
const app = express();
const port = 3000;

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

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
  const { image } = req.files;

  if (!Content || !image) {
    return res.status(400).send('Content and Image are required');
  }

  try {
    const request = new sql.Request();
    const imageData = image.data.toString('base64');
    const query = `
      INSERT INTO dbo.Posts (Content, ImageData, CreatedAt)
      VALUES (@Content, @ImageData, GETDATE());
    `;
    request.input('Content', sql.NVarChar, Content);
    request.input('ImageData', sql.VarBinary, Buffer.from(imageData, 'base64'));

    const result = await request.query(query);
    res.status(201).json(result.recordset[0]);
  } catch (error) {
    console.error('Error adding post:', error.message);
    res.status(500).send('Internal Server Error');
  }
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
