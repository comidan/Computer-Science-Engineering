# Macchina virtuale per il corso di Software Defined Networking @ Politecnico di Milano

## Requisiti:
* Virtualbox (https://www.virtualbox.org)
* Vagrant (https://www.vagrantup.com)
* Un client ssh

## Istruzioni
1. Installare virtualbox e vagrant.
2. Copiare i file di configurazione in una cartella vuota. Se si vuole si può usare git.
3. Aprire una finestra del teminale in questa nuova cartella.
4. Istanziare e avviare la macchina con `vagrant up`
5. Per collegarsi alla macchina virtuale `vagrant ssh`
6. Il disco della macchina host è montato nella cartella `/vagrant`
7. Per spegnere la macchina, uscire dalla macchina (`exit`) e fermarla (`vagrant halt`)
