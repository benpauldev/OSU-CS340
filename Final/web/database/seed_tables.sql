
INSERT INTO country (name)
VALUES ("France"),
       ("Italy"),
       ("China"),
       ("Australia"),
       ("United States"),
       ("Brazil"),
       ("Argentina");

INSERT INTO medium (name)
VALUES ("Painting"),
       ("Ceramics"),
       ("Sculpture"),
       ("Printmaking"),
       ("Drawing"),
       ("Performance"),
       ("Photography"),
       ("Film");

INSERT INTO city (name,fk_country_id)
VALUES ("Lyon",(SELECT country_id FROM country WHERE name="France")),
       ("Rome",(SELECT country_id FROM country WHERE name="Italy")),
       ("Beijing",(SELECT country_id FROM country WHERE name="China")),
       ("Perth",(SELECT country_id FROM country WHERE name="Australia")),
       ("New York",(SELECT country_id FROM country WHERE name="United States")),
       ("Sao Paulo",(SELECT country_id FROM country WHERE name="Brazil")),
       ("Buenos Aires",(SELECT country_id FROM country WHERE name="Argentina"));

INSERT INTO artists (fname,lname,year_of_birth,year_of_death)
VALUES ("Andre","Vermare",1869,1949),
       ("Michaelangelo",null,1475,1564),
       ("Ai","Weiwei",1957,null),
       ("Micky","Allan",1944,null),
       ("Jeff","Koons",1955,null),
       ("Andy","Warhol",1928,1987),
       ("Humberto","Mauro",1897,1983),
       ("Marta","Minujin",1943,null);

INSERT INTO artists_medium (artists_id,medium_id)
VALUES ((SELECT id FROM artists WHERE fname = "Andre" AND lname="Vermare"),
              (SELECT id FROM medium WHERE name ="Sculpture")),
       ((SELECT id FROM artists WHERE fname ="Michaelangelo"),
              (SELECT id FROM medium WHERE name="Painting")),
       ((SELECT id FROM artists WHERE fname ="Michaelangelo"),
              (SELECT id FROM medium WHERE name="Sculpture")),
       ((SELECT id FROM artists WHERE fname="Ai" AND lname="Weiwei"),
              (SELECT id FROM medium WHERE name="Performance")),
       ((SELECT id FROM artists WHERE fname="Ai" AND lname="Weiwei"),
              (SELECT id FROM medium WHERE name="Ceramics")),
       ((SELECT id FROM artists WHERE fname="Micky" AND lname="Allan"),
              (SELECT id FROM medium WHERE name="Photography")),
       ((SELECT id FROM artists WHERE fname="Jeff" AND lname="Koons"),
              (SELECT id FROM medium WHERE name="Sculpture")),
       ((SELECT id FROM artists WHERE fname="Jeff" AND lname="Koons"),
              (SELECT id FROM medium WHERE name="Painting")),
       ((SELECT id FROM artists WHERE fname="Andy" AND lname="Warhol"),
              (SELECT id FROM medium WHERE name="Printmaking")),
       ((SELECT id FROM artists WHERE fname="Humberto" AND lname="Mauro"),
              (SELECT id FROM medium WHERE name="Film")),
       ((SELECT id FROM artists WHERE fname="Marta" AND lname="Minujin"),
              (SELECT id FROM medium WHERE name="Drawing"));

INSERT INTO artists_residence (artists_id,city_id)
VALUES ((SELECT id FROM artists WHERE fname = "Andre" AND lname="Vermare"),
              (SELECT id FROM city WHERE name ="Lyon")),
       ((SELECT id FROM artists WHERE fname ="Michaelangelo"),
              (SELECT id FROM city WHERE name="Rome")),
       ((SELECT id FROM artists WHERE fname="Ai" AND lname="Weiwei"),
              (SELECT id FROM city WHERE name="Beijing")),
       ((SELECT id FROM artists WHERE fname="Micky" AND lname="Allan"),
              (SELECT id FROM city WHERE name="Perth")),
       ((SELECT id FROM artists WHERE fname="Jeff" AND lname="Koons"),
              (SELECT id FROM city WHERE name="New York")),
       ((SELECT id FROM artists WHERE fname="Andy" AND lname="Warhol"),
              (SELECT id FROM city WHERE name="New York")),
       ((SELECT id FROM artists WHERE fname="Humberto" AND lname="Mauro"),
              (SELECT id FROM city WHERE name="Sao Paulo")),
       ((SELECT id FROM artists WHERE fname="Marta" AND lname="Minujin"),
              (SELECT id FROM city WHERE name="Buenos Aires"));








