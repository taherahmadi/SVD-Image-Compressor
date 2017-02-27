# SVD-Image-Compressor
Image compression with Singular Value Decomposition
- Second project of Advanced Mathematics
- Written in matlab

(SVD) states that every (m × n)‑matrix A can be written as a product
A = U * Σ * V ^T
where U and V are orthogonal matrices and the the matrix Σ consists of descending non-negative values on its diagonal and zeros elsewhere. The entries σ1 ≥ σ2 ≥ σ3 ≥ … ≥ 0 on the diagonal of Σ are called the singular values (SVs) of A. Geometrically, Σ maps the j‑th unit coordinate vector of n‑dimensional space to the j‑th coordinate vector of m‑dimensional space, scaled by the factor σj. Orthogonality of U and V means that they correspond to rotations (possibly followed by a reflection) of m‑dimensional and n‑dimensional space respectively. Therefore only Σ changes the length of vectors.

##Using SVD for image compression
We can decompose a given image into the three color channels red, green and blue. Each channel can be represented as a (m × n)‑matrix with values ranging from 0 to 255. We will now compress the matrix A representing one of the channels.
To do this, we compute an approximation to the matrix A that takes only a fraction of the space to store.
The general idea is: a grayscale bitmap image is a big 2d array of numbers. Each number describes how intense a pixel is. 0 is black, 255 is white. A color image works the same way except there are three 2d arrays, one each for the red, blue and green components of each image. So to store a color image we need eight bits per color channel, for every single pixel in the image. That's a lot of data (and that's why people don't usually store images as bitmaps). Fortunately there are more efficient ways to store data such as SVD-Compress' method:

- We'll find three specific matrices that when multiplied together equal the original matrix.
- These new matrices aren't any better then the original one, but they do have one handy property: The most "significant" parts of the original matrix are all pushed to the top left corners of the three new matrices.
- We can reduce the amount of data we're storing by chopping off the bottom right of each of the three smaller matrices. When you mulitply the trimmed matrices together you get a matrix the same size as the orignal matrix which closely resembles the original matrix, except you need less data to get it.
- If you chopped too much the compressed version of the matrix won't look very much like the original, but if you're careful there isn't any perceptible difference between the two.
