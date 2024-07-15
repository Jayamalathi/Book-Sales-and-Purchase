<?php

@include 'config.php';

if(isset($_POST['submit'])){

   $filter_name = filter_var($_POST['name'], FILTER_SANITIZE_STRING);
   $name = mysqli_real_escape_string($conn, $filter_name);
   $filter_email = filter_var($_POST['email'], FILTER_SANITIZE_STRING);
   $email = mysqli_real_escape_string($conn, $filter_email);
   $filter_num = filter_var($_POST['num'], FILTER_SANITIZE_STRING);
   $num = mysqli_real_escape_string($conn, $filter_num);
   $filter_book = filter_var($_POST['book'], FILTER_SANITIZE_STRING);
   $book = mysqli_real_escape_string($conn, $filter_book);
   $filter_bookauthor = filter_var($_POST['bookauthor'], FILTER_SANITIZE_STRING);
   $bookauthor = mysqli_real_escape_string($conn, $filter_bookauthor);
   $filter_price = filter_var($_POST['price'], FILTER_SANITIZE_STRING);
   $price = mysqli_real_escape_string($conn, $filter_price);

         mysqli_query($conn, "INSERT INTO `resale`(username, email,contact,bookname,author,price) VALUES('$name', '$email', '$num','$book','$bookauthor','$price')") or die('query failed');
         $message[] = 'resale data stored successfully!';
        //  header('location:login.php');
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>resale</title>

   <!-- font awesome cdn link  -->
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

   <!-- custom css file link  -->
   <link rel="stylesheet" href="css/style.css">

</head>
<body>

<?php
if(isset($message)){
   foreach($message as $message){
      echo '
      <div class="message">
         <span>'.$message.'</span>
         <i class="fas fa-times" onclick="this.parentElement.remove();"></i>
      </div>
      ';
   }
}
?>
   
<section class="form-container">

   <form action="" method="post">
      <h3>Registration for resale</h3>
      <input type="text" name="name" class="box" placeholder="enter username" required>
      <input type="email" name="email" class="box" placeholder="enter email" required>
      <input type="integer" name="num" class="box" placeholder="enter contact number" required>
      <input type="text" name="book" class="box" placeholder="enter the book for resale" required>
      <input type="text" name="bookauthor" class="box" placeholder="enter the book author" required>
      <input type="integer" name="price" class="box" placeholder="enter the price of each book" required>
      <input type="submit" class="btn" name="submit" value="submit">
      <!-- <p>already have an account? <a href="login.php">login now</a></p> -->
   </form>

</section>

</body>
</html>
