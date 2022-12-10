<a name="readme-top"></a>

<div align="center">


  <br/>

  <h3><b>Documentation</b></h3>

</div>

<!-- TABLE OF CONTENTS -->

# 📗 Table of Contents

- [📖 About the Project](#about-project)
  - [Problem](#problem)
  - [Solution](#solution)  
  - [🛠 Built With](#built-with)
    - [Tech Stack](#tech-stack)
    - [Key Features](#key-features)
- [💻 Getting Started](#getting-started)
  - [Setup](#setup)
  - [Prerequisites](#prerequisites)
  - [Install](#install)
  - [Usage](#usage)
  - [Run tests](#run-tests)
- [👥 Author](#authors)
- [🤝 Contributing](#contributing)
- [⭐️ Show your support](#support)
- [📝 License](#license)

<!-- PROJECT DESCRIPTION -->

# 📖 Jerry's Quick Mart <a name="about-project"></a>

> In this project, I have built a solution for Jerry's market. He needed checkout software 3 days before his grand opening, so I developed an app based on OOP to receive an inventory from a .txt file and print a receipt to a new .txt with a transaction number.

## Problem <a name= "problem"></a>
### Jerry requires the following functionalities:
- Select whether the customer is a Rewards Member or a Regular customer.
- Add items to the cart.
- Remove individual items from the cart, with the empty cart option.
- View cart
- Checkout and print receipt
- Cancel transaction

Inventory should be passed into the application in a text file, with the item information on each line. The receipt should be printed as a .txt file, with the transaction number and date included in the file name. The inventory should be updated after checkout.

## Solution <a name="solution"></a>

[Video explanation](https://www.loom.com/share/09f0c3700f244f55af054b304a9100cd)

I have created a plain CLI app so Jerry's employees can interact with the inventory previously loaded with the inventory.txt file.

One of the first things that de app will ask is whether the customer status is a member or not, giving a quick solution for the first problem.

After that the employee can choose between 6 options that are:

- Shop
- Remove from cart
- View cart
- checkout
- Cancel transaction
- Quit

### Shop:
- In this section, we can select an Item from the shown list using their index.
- After that, the app will ask how many items we need.
- Finally, our item with its desired quantity will be added to the cart.
- This section ends by asking if we need to add a new Item or not.

### Remove from the cart:
- Here my app shows 3 options:
  - Remove item from the cart: Here we select the item we desire to eliminate individually.
  - Remove all items from the cart: Here we just erase all items added to the cart.
  - Go back to the main menu: in case you change your mind.

### View cart:
- Here we print in our terminal a preview of our cart showing us the name of the item with its selected quantity, unit price, and total price.
- We also can preview in detail what is the final amount that the customer needs to pay, showing subtotal, tax `(if it's taxable)` and the sum of those two as a Total.

### Checkout:
- First, the app will ask for the amount of money that the customer will use to pay.
  - if it's not enough the app will print `not enough cash` and it'll ask again.
- If we input the correct amount of cash the app will print us a receipt with the same information that the cart showed us but also with the amount of money that our members saved! all of this appears in a new file named after its number of transactions and date.

Optional future implementation options:
- We can use `Thor` for our CLI for a better user experience.
- we can edit our cart by decreasing or increasing the number of items.




## 🛠 Built With <a name="built-with"></a>

### Tech Stack <a name="tech-stack"></a>

> I use Ruby for the whole implementation because It's the best option for an OOP-based app. And for the testing suit, I've used RSpec.

<details>
  <summary>Client</summary>
  <ul>
    <li><a href="https://www.ruby-lang.org">Ruby</a></li>
  </ul>
</details>

<!-- Features -->

### Key Features <a name="key-features"></a>

> The main features of the app are:

- **Shop items and add them to the cart**
- **Show a cart preview**
- **Checkout and printing receipt**

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- GETTING STARTED -->

## 💻 Getting Started <a name="getting-started"></a>

> Follow this steps to start the application.

To get a local copy up and running, follow these steps.

### Prerequisites

In order to run this project you need Ruby installed on your computer.

### Setup

Clone this repository to your desired folder:
1. Open the terminal

2. Clone the repository

```bash
  git clone https://github.com/Artbsc1992/Jerry-s-Quick-Mart.git
```
3. Enter in to the folder:
```bash
  cd Jerry-s-Quick-Mart
```

4. Install dependencies:
```bash
  bundle install
```



### Usage

To run the project, execute the following command:

```sh
  ruby main.rb
```

### Run tests

To run tests, run the following command:

```bash
  rspec test
```


<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- AUTHOR -->

## 👥 Author <a name="authors"></a>


👤 **Arturo Hermida**

- GitHub: [@Artbsc1992](https://github.com/Artbsc1992)
- Twitter: [@Arturo_D_Rock](https://twitter.com/Arturo_D_Rock)
- LinkedIn: [Arturo Hermida](https://www.linkedin.com/in/arturo-hermida29/)


<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- CONTRIBUTING -->

## 🤝 Contributing <a name="contributing"></a>

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](../../issues/).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- SUPPORT -->

## ⭐️ Show your support <a name="support"></a>

If you like this project don't forget to give stars.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- LICENSE -->

## 📝 License <a name="license"></a>

This project is [MIT](./LICENSE) licensed.

_NOTE: we recommend using the [MIT license](https://choosealicense.com/licenses/mit/) - you can set it up quickly by [using templates available on GitHub](https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/adding-a-license-to-a-repository). You can also use [any other license](https://choosealicense.com/licenses/) if you wish._

<p align="right">(<a href="#readme-top">back to top</a>)</p>
