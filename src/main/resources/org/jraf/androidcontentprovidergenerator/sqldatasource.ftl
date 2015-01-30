<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.${entity.packageName};

import android.content.Context;
import android.database.Cursor;
import android.support.annotation.NonNull;

import ${config.providerJavaPackage}.${config.sqliteOpenHelperClassName};
import ${config.providerJavaPackage}.base.AbstractSqliteDataSource;
import ${config.providerJavaPackage}.base.DatabaseModelHandler;
import ${config.providerJavaPackage}.base.DatabaseSerializer;

/**
<#if entity.documentation??>
 * ${entity.documentation}
<#else>
 * Sqlite data source for the {@code ${entity.nameLowerCase}} table.
</#if>
 * <p>A data source to be used with {@link org.gawst.asyncdb.AsynchronousDbHelper AsynchronousDbHelper}.</p>
 * @see ${entity.nameCamelCase}DatabaseSerializer
 */
public class ${entity.nameCamelCase}SqliteDataSource extends AbstractSqliteDataSource<${entity.nameCamelCase}Model, ${entity.nameCamelCase}Cursor, ${entity.nameCamelCase}Selection> {
    /**
     * Contructor.
     *
     * <p>Uses a {@link ${config.providerJavaPackage}.${entity.packageName}.${entity.nameCamelCase}DatabaseModelHandler} to read/write data in the database.</p>
     *
     * @param context Context used to get the {@link android.database.sqlite.SQLiteOpenHelper SQLiteOpenHelper} used to access the data
     */
    public ${entity.nameCamelCase}SqliteDataSource(@NonNull Context context) {
        this(context, ${entity.nameCamelCase}DatabaseSerializer.INSTANCE);
    }

    /**
     * Contructor.
     *
     * <p>Uses a {@link ${config.providerJavaPackage}.${entity.packageName}.${entity.nameCamelCase}DatabaseModelHandler} to read/write data in the database.</p>
     *
     * @param context Context used to get the {@link android.database.sqlite.SQLiteOpenHelper SQLiteOpenHelper} used to access the data
     */
    public ${entity.nameCamelCase}SqliteDataSource(@NonNull Context context, DatabaseSerializer<${entity.nameCamelCase}Model, ${entity.nameCamelCase}Cursor> serializer) {
        this(context, new ${entity.nameCamelCase}DatabaseModelHandler(serializer));
    }

    /**
     * Contructor.
     *
     * <p>Uses a {@link ${config.providerJavaPackage}.${entity.packageName}.${entity.nameCamelCase}DatabaseModelHandler} to read/write data in the database.</p>
     *
     * @param context Context used to get the {@link android.database.sqlite.SQLiteOpenHelper SQLiteOpenHelper} used to access the data
     */
    public ${entity.nameCamelCase}SqliteDataSource(@NonNull Context context, @NonNull DatabaseModelHandler<${entity.nameCamelCase}Model, ${entity.nameCamelCase}Cursor, ${entity.nameCamelCase}Selection> databaseModelHandler) {
        super(context, ${config.sqliteOpenHelperClassName}.getInstance(context), ${entity.nameCamelCase}Columns.TABLE_NAME, ${config.sqliteOpenHelperClassName}.DATABASE_FILE_NAME, databaseModelHandler);
    }

    @Override
    public ${entity.nameCamelCase}Cursor wrapCursor(Cursor cursor) {
        return new ${entity.nameCamelCase}Cursor(cursor);
    }
}