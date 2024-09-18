WITH chat AS
(
    SELECT * from {{ ref('src_chats') }}
),

categories AS
(
    SELECT * FROM {{ ref('src_categories') }}
),

chat_categories AS 
(
    SELECT chat.*, categories.parent_id, categories.disabled
    FROM chat LEFT JOIN categories
    ON chat.chat_category_id = categories.id
)

SELECT * FROM chat_categories