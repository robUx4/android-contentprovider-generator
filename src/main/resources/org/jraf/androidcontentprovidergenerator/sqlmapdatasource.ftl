<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.${entity.packageName};

import android.content.Context;
import android.database.Cursor;
import android.support.annotation.NonNull;

import ${config.providerJavaPackage}.${config.sqliteOpenHelperClassName};
import ${config.providerJavaPackage}.base.AbstractSqliteMapDataSource;
import ${config.providerJavaPackage}.base.MapDatabaseModelHandler;
import ${config.providerJavaPackage}.base.MapDatabaseSerializer;

/**
<#if entity.documentation??>
 * ${entity.documentation}
<#else>
 * Sqlite Map data source for the {@code ${entity.nameLowerCase}} table.
</#if>
 * <p>A data source to be used with {@link org.gawst.asyncdb.AsynchronousDbHelper AsynchronousDbHelper}.</p>
 * @see ${entity.nameCamelCase}MapDatabaseSerializer
 */
public class ${entity.nameCamelCase}SqliteMapDataSource extends AbstractSqliteMapDataSource<${entity.nameCamelCase}Key, ${entity.nameCamelCase}Value, ${entity.nameCamelCase}Cursor, ${entity.nameCamelCase}Selection> {
    /**
     * Contructor.
     *
     * <p>Uses a {@link ${config.providerJavaPackage}.${entity.packageName}.${entity.nameCamelCase}DatabaseModelHandler} to read/write data in the database.</p>
     *
     * @param context Context used to get the {@link android.database.sqlite.SQLiteOpenHelper SQLiteOpenHelper} used to access the data
     */
    public ${entity.nameCamelCase}SqliteMapDataSource(@NonNull Context context) {
        this(context, ${entity.nameCamelCase}MapDatabaseSerializer.INSTANCE);
    }

    /**
     * Contructor.
     *
     * <p>Uses a {@link ${config.providerJavaPackage}.${entity.packageName}.${entity.nameCamelCase}DatabaseModelHandler} to read/write data in the database.</p>
     *
     * @param context Context used to get the {@link android.database.sqlite.SQLiteOpenHelper SQLiteOpenHelper} used to access the data
     */
    public ${entity.nameCamelCase}SqliteMapDataSource(@NonNull Context context, MapDatabaseSerializer<${entity.nameCamelCase}Key, ${entity.nameCamelCase}Value, ${entity.nameCamelCase}Cursor> serializer) {
        this(context, new ${entity.nameCamelCase}MapDatabaseModelHandler(serializer));
    }

    /**
     * Contructor.
     *
     * <p>Uses a {@link ${config.providerJavaPackage}.${entity.packageName}.${entity.nameCamelCase}DatabaseModelHandler} to read/write data in the database.</p>
     *
     * @param context Context used to get the {@link android.database.sqlite.SQLiteOpenHelper SQLiteOpenHelper} used to access the data
     */
    public ${entity.nameCamelCase}SqliteMapDataSource(@NonNull Context context, @NonNull MapDatabaseModelHandler<${entity.nameCamelCase}Key, ${entity.nameCamelCase}Value, ${entity.nameCamelCase}Cursor, ${entity.nameCamelCase}Selection> databaseModelHandler) {
        super(context, ${config.sqliteOpenHelperClassName}.getInstance(context), ${entity.nameCamelCase}Columns.TABLE_NAME, ${config.sqliteOpenHelperClassName}.DATABASE_FILE_NAME, databaseModelHandler);
    }

    @Override
    public ${entity.nameCamelCase}Cursor wrapCursor(Cursor cursor) {
        return new ${entity.nameCamelCase}Cursor(cursor);
    }

    public <MODEL extends ${entity.nameCamelCase}Key & ${entity.nameCamelCase}Value> Long insert(MODEL value) {
        return insert(value, value);
    }

    public <MODEL extends ${entity.nameCamelCase}Key & ${entity.nameCamelCase}Value> boolean update(MODEL value) {
        return update(value, value);
    }
}