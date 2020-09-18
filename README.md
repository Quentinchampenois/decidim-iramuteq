# Decidim Iramuteq

Simple ruby script that allows to format decidim exports to be iramuteq compliant. 


## How to use it 

Clone the repository

```
    git clone https://github.com/Quentinchampenois/decidim-iramuteq.git
```

Change location to the `decidim-iramuteq` folder

```
    cd decidim-iramuteq
```

Create new directory, if you want, and add files you want to process

```
    mkdir csv_files
```

Run script

```
    ruby main.rb
```

If you call the script as above, you will have to enter the name of the wanted file as following

```
    csv_files/[THE_NAME_OF_YOUR_FILE]
```

You also can set the filename as following

```
    ruby main.rb csv_files/[THE_NAME_OF_YOUR_FILE]
```
