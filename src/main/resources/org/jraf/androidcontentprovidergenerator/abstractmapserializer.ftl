<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.${entity.packageName};

import org.gawst.asyncdb.InvalidDbEntry;

import android.content.ContentValues;
import android.support.annotation.NonNull;

import ${config.providerJavaPackage}.base.MapDatabaseSerializer;

/**
<#if entity.documentation??>
 * ${entity.documentation}
<#else>
 * Default Map Serializer class for the {@code ${entity.nameLowerCase}} table.
</#if>
 * @see ${entity.nameCamelCase}SqliteMapDataSource#${entity.nameCamelCase}SqliteMapDataSource(android.content.Context, ${config.providerJavaPackage}.base.MapDatabaseSerializer)
 */
public class ${entity.nameCamelCase}MapDatabaseSerializer implements MapDatabaseSerializer<${entity.nameCamelCase}Key, ${entity.nameCamelCase}Value, ${entity.nameCamelCase}Cursor> {
    public static final ${entity.nameCamelCase}MapDatabaseSerializer INSTANCE = new ${entity.nameCamelCase}MapDatabaseSerializer();

    private ${entity.nameCamelCase}MapDatabaseSerializer() {
    }

    @NonNull
    @Override
    public ${entity.nameCamelCase}Key getKeyFromCursor(${entity.nameCamelCase}Cursor cursor) throws InvalidDbEntry {
        return new ${entity.nameCamelCase}KeyImpl.Builder(cursor).build();
    }

    @NonNull
    @Override
    public ${entity.nameCamelCase}Value getValueFromCursor(${entity.nameCamelCase}Cursor cursor) {
        return new ${entity.nameCamelCase}ValueImpl.Builder(cursor).build();
    }

    @NonNull
    @Override
    public ContentValues getContentValuesFromData(@NonNull ${entity.nameCamelCase}Key key, @NonNull ${entity.nameCamelCase}Value value, boolean update) {
        ${entity.nameCamelCase}ContentValues values = new ${entity.nameCamelCase}ContentValues(key, value, update);
        return values.values();
    }
}