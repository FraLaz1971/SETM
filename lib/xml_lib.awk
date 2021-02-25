          #this is an example function  
          function myprint(num)
          {
            printf "%6.3g\n", num;
          }
          
          function putDeclaration(){
            print "<?xml version=\"1.0\"?>";
          }

          function openTag(val){
            printf "<%s>", val
          }

          function closeTag(val){
            printf "</%s>", val
          }

          function emptyTag(val){
            openTag(val); closeTag(val)
          }

          function autoTag(val){
            printf "<%s/>", val
          }

          function comment(val){
            printf "<!--%s-->", val
          }
