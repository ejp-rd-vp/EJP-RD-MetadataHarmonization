(This is copy/paste from the MoSCoW document from the Explorathon in Vienna)

*It is best to either use curl to explore the LDP server, or use a Header Editor in your browser and request text/turtle.  If you don't, you wont see the metadata associated with folders.*


## INFO FOR METADATA GROUP PARTICIPANTS:
I have set-up a sandbox server for us to play with (I will set up a dedicated server as soon as I get permission to spend EJP money on Google Cloud ;-) )
The account is  username/pass:  ejp/ejp

The LDP Server is at:  http://training.fairdata.solutions/DAV/home/LDP_EJP/

Read-access is public.  For HTTP POST/PUT/DELETE, you will need to add -u ejp:ejp to your request.  An example request is below.  

The content of the file “container.ttl” is:

<pre>
    @prefix ldp: <http://www.w3.org/ns/ldp#> .
    <> a ldp:Container .
</pre>

Example request:


    curl -v -H "Accept: text/turtle" -H "Content-type: text/turtle" -u ejp:ejp --data-binary @container.ttl -H "Slug: DemoEJP_Container" http://training.fairdata.solutions/DAV/home/LDP_EJP/


If you now browse (in your Web browser) to 

    http://training.fairdata.solutions/DAV/home/LDP_EJP/

you will find that it contains a new “folder” (LDP Container) called DemoEJP_Container

Look at the LDP documentation to see how to do other things (or ask me to create a tutorial… I am happy to do so, as quickly as I can!).  The SPARQL endpoint is at:


    http://training.fairdata.solutions/sparql

PLEASE LIMIT YOUR SPARQL TO THE NAMED GRAPH: 

     http://training.fairdata.solutions/DAV/home/LDP_EJP/

(this will avoid confusion, as I have a TON of other data on that server)


