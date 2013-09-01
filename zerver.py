import sys
import socket
import traceback
import time
import natlink
from natlinkutils import *

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect(('192.168.1.92', 5000))
g = None

def run():
    global s
    global g
    natlink.natConnect(1) #if natlink.isNatSpeakRunning() else wait
    try:
        print 'MicState:', natlink.getMicState()
        natlink.setBeginCallback(beginCallback)
        natlink.setChangeCallback(changeCallback)
        updateGrammarFromClient()
        natlink.setMicState('on')
        natlink.waitForSpeech(300)
        #data = client_socket.recv(512)
        #data = raw_input ( "SEND( TYPE q or Q to Quit):" )
    except:
        #print sys.exc_info()
        print traceback.format_exc()
    finally:
        g.unload()
        natlink.natDisconnect()
        print 'iDisconnected.'
        s.close()
        print 'all closed'
def beginCallback(moduleInfo, checkAll=None):
    print 'beginCallback'
    #updateGrammarFromClient()
    print '..loaded.'
def changeCallback(event_type, args): #mic or user
    print 'changeCallback'
    print event_type, args
def updateGrammarFromClient():
    global s
    global g
    if g:
        g.unload()
        g = None
    g = Grammar()
    s.send('.poll\n')
    text = s.makefile().readline()
    print "Got this grammar:", text
    g.load(text, 1);
    #g.activateSet(['main'])
    g.activateAll()
    g.setExclusive(1)
    return(None)

class Grammar(GrammarBase):
    def gotResultsInit(self,a, w):
        global s
        s.send(str(a)+"\n")
        print 'init',a, w
    #def gotResults(self,words,r):
    #    print "total", words
    #def gotResults_main(self,words,resObj):
    #    print "main", words, resObj

run()
print('Finished.')
#sys.stdin.readline()
time.sleep(15)
