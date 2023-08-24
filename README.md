Kobo eReader has a nice feature to organize books by `collection`.
https://help.kobo.com/hc/en-us/articles/360033887953-Organize-your-eBooks-on-your-Kobo-eReader

However, if there are too many books, creating collection and add books to the collection can be 
tedious. 

This project is to create book collections by the directory name using dbt.

## How to use this tool
1. Checkout [dbt-sqlite](https://github.com/zxiex/dbt-sqlite)
```shell 
cd /tmp/
git clone https://github.com/zxiex/dbt-sqlite.git
```

Note that `https://github.com/zxiex/dbt-sqlite` is a Fork of
`https://github.com/codeforkjeff/dbt-sqlite` to fix an [issue](https://github.com/codeforkjeff/dbt-sqlite/issues/47).

2. Checkout this repo
```shell
git clone https://github.com/zxiex/kobo-book-collections-dbt.git
cd kobo-book-collections-dbt
```
2. Prepare the virtual env (suppose `pipenv` is installed)
```shell
pipenv install 
```
3. Plug the Kobo eReader into Computer (Suppose all the books are put into folders as the expected collection)
4. Copy the sqlite database file from eReader to `./data` folder (Better to have a backup copy of the file)
On Mac, the file is `/Volumes/KOBOeReader/.kobo/KoboReader.sqlite`
```shell
cp /Volumes/KOBOeReader/.kobo/KoboReader.sqlite data/
```
5. run `dbt`
```shell 
make run
```

```text
pipenv run dbt run                                                                                                                                                  
20:47:41  Running with dbt=1.6.1                                                                                                                                    
20:47:41  Registered adapter: sqlite=1.4.0                                                                                                                          
20:47:41  Unable to do partial parsing because saved manifest not found. Starting full parse.                                                                       
20:47:41  Found 2 models, 1 test, 1 source, 0 exposures, 0 metrics, 343 macros, 0 groups, 0 semantic models                                                         
20:47:41                                                                                                                                                            
20:47:41  Concurrency: 1 threads (target='dev')                                                                                                                     
20:47:41                                                                                                                                                            
20:47:41  1 of 2 START sql incremental model main.ShelfContent ........................... [RUN]                                                                    
20:47:41  1 of 2 OK created sql incremental model main.ShelfContent ...................... [OK in 0.08s]                                                            
20:47:41  2 of 2 START sql incremental model main.Shelf .................................. [RUN]                                                                    
20:47:41  2 of 2 OK created sql incremental model main.Shelf ............................. [OK in 0.04s]                                                            
20:47:41                                                                                                                                                            
20:47:41  Finished running 2 incremental models in 0 hours 0 minutes and 0.16 seconds (0.16s).                                                                      
20:47:41                                                                                                                                                            
20:47:41  Completed successfully                                                                                                                                    
20:47:41                                                                                                                                                            
20:47:41  Done. PASS=2 WARN=0 ERROR=0 SKIP=0 TOTAL=2    
```

6. Copy the updated `KoboReader.sqlite` back to eReader
```shell
cp data/KoboReader.sqlite  /Volumes/KOBOeReader/.kobo/KoboReader.sqlite
```

7. eject the eReader and done
```shell
diskutil eject /Volumes/KOBOeReader 
```