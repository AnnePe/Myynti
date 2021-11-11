<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style>
.oikealle{
	text-align:right;
	font-family: 'PT Sans', sans-serif;
	font-size: 0.9em;
	background-color: #21d177;
	
	
}
.vasemmalle{
	text-align:left;
	font-family: 'PT Sans', sans-serif;
	font-size: 0.9em;
	background-color: #21d177;
	
}

</style>
<title>Myynnin asiakkaat</title>

</head>
<body>
<table id="listaus" border="1"> 
	<thead>				
		<tr>
			<th colspan="2" class="oikealle">Hakusana:</th>
			<th  class="vasemmalle"><input type="text" id="hakusana"></th>
			<th class="vasemmalle"><input type="button" value="Hae" id="hakunappi"></th>
		</tr>
		<tr>
			
			<th class="vasemmalle">Etunimi</th>
			<th class="vasemmalle">Sukunimi</th>
			<th class="vasemmalle">Puhelin</th>
			<th class="vasemmalle">Sposti</th>
										
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
<script>
$(document).ready(function(){                         //kaikki jquery hommat tän alle
	haeAsiakkaat();
	$("#hakunappi").click(function(){
    	//console.log($("#hakusana").val()); /kutsu haku funktiota
    	haeAsiakkaat();
     });
	 $(document.body).on("keydown",function(event){
	    	if(event.which==13){
	    		haeAsiakkaat();
	    	}
	    });
	    $("#hakusana").focus();//viedään kursori haksuana kenttään
});
function haeAsiakkaat(){
	$("#listaus tbody").empty();
	$.ajax({url:"asiakkaat/"+$("#hakusana").val(), type:"GET", dataType:"json", success:function(result){   //Funktio palauttaa tiedot json-objektina
		$.each(result.asiakkaat, function(i, field){    //haetaan backendistä autot ajaxilla @webservlet"autot" Autot servletissä
        	var htmlStr;						   //määritellään metodi millä haeteen GET
        	htmlStr+="<tr>";
        	
        	htmlStr+="<td>"+field.etunimi+"</td>";
        	htmlStr+="<td>"+field.sukunimi+"</td>";
        	htmlStr+="<td>"+field.puhelin+"</td>";
        	htmlStr+="<td>"+field.sposti+"</td>";
        	htmlStr+="</tr>";
        	$("#listaus tbody").append(htmlStr);//elementin id=listaus lisätään tbody
        });	
				
		//console.log(result); //jos haluat näyttää consolissa toimiiko ajax kutsu
	}});
}



</script>
</body>
</html>